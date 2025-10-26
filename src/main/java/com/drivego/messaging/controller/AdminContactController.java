package com.drivego.messaging.controller;

import com.drivego.messaging.model.ContactMessage;
import com.drivego.messaging.service.ContactMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminContactController {
    
    @Autowired
    private ContactMessageService contactMessageService;
    
    /**
     * Admin Contact Messages List
     */
    @GetMapping("/contacts")
    public String listContactMessages(@RequestParam(value = "status", required = false) String status,
                                    Model model) {
        
        List<ContactMessage> messages;
        
        if (status != null && !status.isEmpty()) {
            messages = contactMessageService.getMessagesByStatus(status.toUpperCase());
            model.addAttribute("filterStatus", status.toUpperCase());
        } else {
            messages = contactMessageService.getAllMessages();
        }
        
        model.addAttribute("messages", messages);
        
        // Add statistics
        model.addAttribute("newCount", contactMessageService.countByStatus("NEW"));
        model.addAttribute("readCount", contactMessageService.countByStatus("READ"));
        model.addAttribute("repliedCount", contactMessageService.countByStatus("REPLIED"));
        model.addAttribute("closedCount", contactMessageService.countByStatus("CLOSED"));
        model.addAttribute("totalCount", messages.size());
        
        System.out.println("📋 Admin viewing contact messages");
        System.out.println("📊 Displaying " + messages.size() + " messages (New: " + contactMessageService.countByStatus("NEW") + ")");
        
        return "messaging/admin/contacts";
    }
    
    /**
     * View Individual Contact Message
     */
    @GetMapping("/contacts/{id}")
    public String viewContactMessage(@PathVariable Long id, Model model, RedirectAttributes ra) {
        
        Optional<ContactMessage> messageOpt = contactMessageService.getMessageById(id);
        
        if (messageOpt.isPresent()) {
            ContactMessage message = messageOpt.get();
            
            // Auto-mark as READ if it's NEW
            if ("NEW".equals(message.getStatus())) {
                contactMessageService.updateStatus(id, "READ");
                message.setStatus("READ"); // Update the object too
            }
            
            model.addAttribute("message", message);
            
            System.out.println("👁️ Admin viewing message #" + id);
            
            return "messaging/admin/contact-detail";
        } else {
            ra.addFlashAttribute("error", "Message not found");
            return "redirect:/admin/contacts";
        }
    }
    
    /**
     * Reply to Contact Message
     */
    @PostMapping("/contacts/{id}/reply")
    public String replyToMessage(@PathVariable Long id,
                               @RequestParam("reply") String reply,
                               @AuthenticationPrincipal UserDetails userDetails,
                               RedirectAttributes ra) {
        
        try {
            String adminEmail = userDetails.getUsername();
            
            ContactMessage updatedMessage = contactMessageService.replyToMessage(id, reply, adminEmail);
            
            if (updatedMessage != null) {
                System.out.println("✉️ Reply sent for message #" + id + " by: " + adminEmail);
                ra.addFlashAttribute("success", "Reply sent successfully!");
            } else {
                ra.addFlashAttribute("error", "Message not found");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error sending reply: " + e.getMessage());
            ra.addFlashAttribute("error", "Failed to send reply");
        }
        
        return "redirect:/admin/contacts/" + id;
    }
    
    /**
     * Update Message Status
     */
    @PostMapping("/contacts/{id}/status")
    public String updateMessageStatus(@PathVariable Long id,
                                    @RequestParam("status") String status,
                                    RedirectAttributes ra) {
        
        try {
            ContactMessage updatedMessage = contactMessageService.updateStatus(id, status.toUpperCase());
            
            if (updatedMessage != null) {
                System.out.println("📝 Message #" + id + " status updated to: " + status);
                ra.addFlashAttribute("success", "Status updated successfully!");
            } else {
                ra.addFlashAttribute("error", "Message not found");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error updating status: " + e.getMessage());
            ra.addFlashAttribute("error", "Failed to update status");
        }
        
        return "redirect:/admin/contacts/" + id;
    }
    
    /**
     * Delete Contact Message
     */
    @PostMapping("/contacts/{id}/delete")
    public String deleteMessage(@PathVariable Long id, RedirectAttributes ra) {
        
        try {
            Optional<ContactMessage> messageOpt = contactMessageService.getMessageById(id);
            
            if (messageOpt.isPresent()) {
                contactMessageService.deleteMessage(id);
                System.out.println("🗑️ Message #" + id + " deleted by admin");
                ra.addFlashAttribute("success", "Message deleted successfully!");
            } else {
                ra.addFlashAttribute("error", "Message not found");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error deleting message: " + e.getMessage());
            ra.addFlashAttribute("error", "Failed to delete message");
        }
        
        return "redirect:/admin/contacts";
    }
}
