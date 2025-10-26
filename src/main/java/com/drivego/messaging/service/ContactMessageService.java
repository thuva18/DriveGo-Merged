package com.drivego.messaging.service;

import com.drivego.messaging.model.ContactMessage;
import com.drivego.messaging.repository.ContactMessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ContactMessageService {
    
    @Autowired
    private ContactMessageRepository contactMessageRepository;
    
    /**
     * Save a new contact message
     */
    public ContactMessage saveMessage(ContactMessage message) {
        if (message.getCreatedAt() == null) {
            message.setCreatedAt(LocalDateTime.now());
        }
        if (message.getStatus() == null) {
            message.setStatus("NEW");
        }
        return contactMessageRepository.save(message);
    }
    
    /**
     * Get all contact messages
     */
    public List<ContactMessage> getAllMessages() {
        return contactMessageRepository.findAllByOrderByCreatedAtDesc();
    }
    
    /**
     * Get messages by status
     */
    public List<ContactMessage> getMessagesByStatus(String status) {
        return contactMessageRepository.findByStatusOrderByCreatedAtDesc(status);
    }
    
    /**
     * Get a message by ID
     */
    public Optional<ContactMessage> getMessageById(Long id) {
        return contactMessageRepository.findById(id);
    }
    
    /**
     * Get messages by email
     */
    public List<ContactMessage> getMessagesByEmail(String email) {
        return contactMessageRepository.findByEmailOrderByCreatedAtDesc(email);
    }
    
    /**
     * Update message status
     */
    public ContactMessage updateStatus(Long messageId, String status) {
        Optional<ContactMessage> messageOpt = contactMessageRepository.findById(messageId);
        if (messageOpt.isPresent()) {
            ContactMessage message = messageOpt.get();
            message.setStatus(status);
            return contactMessageRepository.save(message);
        }
        return null;
    }
    
    /**
     * Reply to a message
     */
    public ContactMessage replyToMessage(Long messageId, String reply, String repliedBy) {
        Optional<ContactMessage> messageOpt = contactMessageRepository.findById(messageId);
        if (messageOpt.isPresent()) {
            ContactMessage message = messageOpt.get();
            message.setAdminReply(reply);
            message.setRepliedAt(LocalDateTime.now());
            message.setRepliedBy(repliedBy);
            message.setStatus("REPLIED");
            return contactMessageRepository.save(message);
        }
        return null;
    }
    
    /**
     * Delete a message
     */
    public void deleteMessage(Long messageId) {
        contactMessageRepository.deleteById(messageId);
    }
    
    /**
     * Count messages by status
     */
    public long countByStatus(String status) {
        return contactMessageRepository.countByStatus(status);
    }
    
    /**
     * Count new messages (NEW + READ)
     */
    public long countNewMessages() {
        return contactMessageRepository.countByStatusIn(List.of("NEW", "READ"));
    }
    
    /**
     * Get recent messages (last 10)
     */
    public List<ContactMessage> getRecentMessages() {
        return contactMessageRepository.findTop10ByOrderByCreatedAtDesc();
    }
}
