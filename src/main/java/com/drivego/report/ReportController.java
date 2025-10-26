package com.drivego.report;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
public class ReportController {
    private final ReportService reportService;
    private final ReportRepository repo;

    public ReportController(ReportService rs, ReportRepository repo) {
        this.reportService = rs; this.repo = repo;
    }

    // Existing analytics preview page
    @GetMapping("/reports")
    public String reports(
            @RequestParam(name="type", defaultValue="revenue") String type,
            @RequestParam(name="from", required=false) String from,
            @RequestParam(name="to",   required=false) String to,
            Model model) {

        if (isBlank(from) || isBlank(to)) {
            model.addAttribute("error", "Start date and End date are required.");
            model.addAttribute("chartTitle", "Report Preview");
            return "admin-reports";
        }
        if (from.compareTo(to) > 0) {
            model.addAttribute("error", "Start date cannot be after End date.");
            model.addAttribute("chartTitle", "Report Preview");
            return "admin-reports";
        }

        try {
            var r = reportService.generate(type, from, to);
            model.addAttribute("chartTitle", r.get("chartTitle"));
            
            // Convert labels and values to JSON strings for the JSP
            java.util.List<?> labels = (java.util.List<?>) r.get("labels");
            java.util.List<?> values = (java.util.List<?>) r.get("values");
            
            if (labels != null && values != null && !labels.isEmpty()) {
                com.fasterxml.jackson.databind.ObjectMapper om = new com.fasterxml.jackson.databind.ObjectMapper();
                model.addAttribute("chartLabelsJson", om.writeValueAsString(labels));
                model.addAttribute("chartDataJson", om.writeValueAsString(values));
                
                // Create reportRows for the table
                java.util.List<java.util.Map<String, Object>> rows = new java.util.ArrayList<>();
                double total = 0.0;
                for (int i = 0; i < labels.size(); i++) {
                    java.util.Map<String, Object> row = new java.util.HashMap<>();
                    row.put("label", labels.get(i));
                    Object val = values.get(i);
                    double numVal = val instanceof Number ? ((Number)val).doubleValue() : 0.0;
                    if ("revenue".equalsIgnoreCase(type)) {
                        row.put("value", String.format("LKR %.2f", numVal));
                    } else {
                        row.put("value", String.valueOf(Math.round(numVal)));
                    }
                    rows.add(row);
                    total += numVal;
                }
                model.addAttribute("reportRows", rows);
                
                // Add total
                if ("revenue".equalsIgnoreCase(type)) {
                    model.addAttribute("tableTotalLabel", "Total Revenue");
                    model.addAttribute("tableTotalValue", String.format("LKR %.2f", total));
                } else {
                    model.addAttribute("tableTotalLabel", "Total Count");
                    model.addAttribute("tableTotalValue", String.valueOf(Math.round(total)));
                }
            } else {
                model.addAttribute("error", "No data found for the selected date range.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            model.addAttribute("error", "Could not generate report: " + ex.getMessage());
            model.addAttribute("chartTitle", "Report Preview");
        }
        return "admin-reports";
    }

    // Manage list page
    @GetMapping("/reports/manage")
    public String manage(Model model) {
        java.util.List<Report> reports = repo.findAll();
        model.addAttribute("reports", reports);
        System.out.println("📊 Displaying " + reports.size() + " reports in manage page");
        return "admin-reports-manage";
    }

    // New form
    @GetMapping("/reports/new")
    public String newForm(Model model) {
        model.addAttribute("isNew", true);
        model.addAttribute("report", new Report());
        return "admin-report-form";
    }

    // Create (HTML form POST)
    @PostMapping("/reports")
    public String create(@RequestParam String name,
                         @RequestParam String type,
                         @RequestParam String from,
                         @RequestParam String to,
                         @RequestParam(name="regenerate", required=false) String regenerate,
                         RedirectAttributes ra) {
        if (isBlank(name) || isBlank(type) || isBlank(from) || isBlank(to)) {
            ra.addFlashAttribute("error", "All fields are required.");
            return "redirect:/reports/manage";
        }
        if (from.compareTo(to) > 0) {
            ra.addFlashAttribute("error", "Start date cannot be after End date.");
            return "redirect:/reports/manage";
        }
        try {
            String payload = safeGenerate(type, from, to, regenerate != null);
            Report r = new Report();
            r.setName(name);
            r.setType(type);
            r.setFromDate(LocalDate.parse(from));
            r.setToDate(LocalDate.parse(to));
            r.setPayload(payload);
            Report saved = repo.save(r);
            System.out.println("✅ Report saved successfully with ID: " + saved.getId());
            ra.addFlashAttribute("info", "✅ Report '" + name + "' created successfully (ID: " + saved.getId() + ")");
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "Failed to create report: " + e.getMessage());
        }
        return "redirect:/reports/manage";
    }

    // Edit form
    @GetMapping("/reports/{id}/edit")
    public String editForm(@PathVariable Long id, Model model, RedirectAttributes ra) {
        var r = repo.findById(id);
        if (r.isEmpty()) {
            ra.addFlashAttribute("error", "Report not found");
            return "redirect:/reports/manage";
        }
        model.addAttribute("isNew", false);
        model.addAttribute("report", r.get());
        return "admin-report-form";
    }

    // Update (HTML form POST)
    @PostMapping("/reports/{id}")
    public String update(@PathVariable Long id,
                         @RequestParam String name,
                         @RequestParam String type,
                         @RequestParam String from,
                         @RequestParam String to,
                         @RequestParam(name="regenerate", required=false) String regenerate,
                         RedirectAttributes ra) {
        var opt = repo.findById(id);
        if (opt.isEmpty()) {
            ra.addFlashAttribute("error", "Report not found");
            return "redirect:/reports/manage";
        }
        try {
            Report r = opt.get();
            r.setName(name);
            r.setType(type);
            r.setFromDate(LocalDate.parse(from));
            r.setToDate(LocalDate.parse(to));
            if (regenerate != null) {
                String payload = safeGenerate(type, from, to, true);
                r.setPayload(payload);
            }
            repo.save(r);
            System.out.println("✅ Report updated successfully with ID: " + id);
            ra.addFlashAttribute("info", "✅ Report '" + name + "' updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "Failed to update report: " + e.getMessage());
        }
        return "redirect:/reports/manage";
    }

    // Delete (HTML form POST)
    @PostMapping("/reports/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        try {
            repo.deleteById(id);
            System.out.println("✅ Report deleted successfully with ID: " + id);
            ra.addFlashAttribute("info", "✅ Report deleted successfully");
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "Failed to delete report: " + e.getMessage());
        }
        return "redirect:/reports/manage";
    }

    // View details
    @GetMapping("/reports/{id}")
    public String view(@PathVariable Long id, Model model, RedirectAttributes ra) {
        var r = repo.findById(id);
        if (r.isEmpty()) {
            ra.addFlashAttribute("error", "Report not found");
            return "redirect:/reports/manage";
        }
        model.addAttribute("report", r.get());
        return "admin-report-view";
    }

    private boolean isBlank(String s){ return s==null || s.trim().isEmpty(); }

    // Return JSON string payload for storage
    private String safeGenerate(String type, String from, String to, boolean doGenerate) {
        if (!doGenerate) return "{}";
        try {
            var m = reportService.generate(type, from, to);
            // Use a compact JSON via simple builder; Spring has Jackson on classpath
            com.fasterxml.jackson.databind.ObjectMapper om = new com.fasterxml.jackson.databind.ObjectMapper();
            return om.writeValueAsString(m);
        } catch (Exception e) {
            return "{\"error\":\"" + e.getMessage().replace("\"","'") + "\"}";
        }
    }
}
