package com.drivego.messaging.repository;

import com.drivego.messaging.model.ContactMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ContactMessageRepository extends JpaRepository<ContactMessage, Long> {
    
    /**
     * Find all messages ordered by creation date (newest first)
     */
    List<ContactMessage> findAllByOrderByCreatedAtDesc();
    
    /**
     * Find messages by status ordered by creation date (newest first)
     */
    List<ContactMessage> findByStatusOrderByCreatedAtDesc(String status);
    
    /**
     * Find messages by email ordered by creation date (newest first)
     */
    List<ContactMessage> findByEmailOrderByCreatedAtDesc(String email);
    
    /**
     * Find messages by email (case insensitive) ordered by creation date (newest first)
     */
    @Query("SELECT m FROM ContactMessage m WHERE LOWER(m.email) = LOWER(:email) ORDER BY m.createdAt DESC")
    List<ContactMessage> findByEmailIgnoreCaseOrderByCreatedAtDesc(@Param("email") String email);
    
    /**
     * Count messages by status
     */
    long countByStatus(String status);
    
    /**
     * Count messages by multiple statuses
     */
    long countByStatusIn(List<String> statuses);
    
    /**
     * Find top 10 recent messages
     */
    List<ContactMessage> findTop10ByOrderByCreatedAtDesc();
    
    /**
     * Find messages containing text in subject or message
     */
    @Query("SELECT m FROM ContactMessage m WHERE LOWER(m.subject) LIKE LOWER(CONCAT('%', :searchText, '%')) OR LOWER(m.message) LIKE LOWER(CONCAT('%', :searchText, '%')) ORDER BY m.createdAt DESC")
    List<ContactMessage> findBySubjectOrMessageContainingIgnoreCase(@Param("searchText") String searchText);
    
    /**
     * Count total messages
     */
    @Query("SELECT COUNT(m) FROM ContactMessage m")
    long countTotalMessages();
    
    /**
     * Find unread messages (NEW or READ status)
     */
    @Query("SELECT m FROM ContactMessage m WHERE m.status IN ('NEW', 'READ') ORDER BY m.createdAt DESC")
    List<ContactMessage> findUnreadMessages();
    
    /**
     * Find replied messages
     */
    @Query("SELECT m FROM ContactMessage m WHERE m.status = 'REPLIED' ORDER BY m.repliedAt DESC")
    List<ContactMessage> findRepliedMessages();
}
