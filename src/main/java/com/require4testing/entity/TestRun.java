package com.require4testing.entity;

import javax.persistence.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

@Entity
@Table(name = "test_runs")
public class TestRun {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    @Column(length = 1000)
    private String description;

    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @Column(name = "manager_name")
    private String managerName;

    @Enumerated(EnumType.STRING)
    private TestRunStatus status;

    @OneToMany(mappedBy = "testRun", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RunAssignment> assignments;

    public TestRun() {
        this.createdDate = new Date();
        this.status = TestRunStatus.CREATED;
        this.assignments = new java.util.ArrayList<>();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public TestRunStatus getStatus() {
        return status;
    }

    public void setStatus(TestRunStatus status) {
        this.status = status;
    }

    public List<RunAssignment> getAssignments() {
        return assignments;
    }

    public void setAssignments(List<RunAssignment> assignments) {
        this.assignments = assignments;
    }

    @Override
    public String toString() {
        return "TestRun{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                '}';
    }
}

enum TestRunStatus {
    CREATED, IN_PROGRESS, COMPLETED
}
