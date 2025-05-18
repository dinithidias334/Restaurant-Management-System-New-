
package com.resturent.model;

public class Employee {
    private int id;
    private String name;
    private String email;
    private String role;
    private String number;
    private String password;
    private String status;

    // No-argument constructor (required for some frameworks)
    public Employee() {
    }

    // All-argument constructor
    public Employee(String name, String email, String role, String number, String password, String status) {
        this.name = name;
        this.email = email;
        this.role = role;
        this.number = number;
        this.password = password;
        this.status = status;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDepartment() { return role; }
    public void setDepartment(String role) { this.role = role; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }


    public void setRole(String role) { this.role = role; }

    public String getrole() {
        return role;
    }
}
