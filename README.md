# AWS Terraform Conditional Expressions, Dynamic Blocks, and Splat Expressions

This repository contains hands-on implementations of **Terraform expressions** that help in writing cleaner, more maintainable, and environment-aware infrastructure as code. The examples here are built and tested by me as part of my AWS Terraform learning series.

## Table of Contents
1. [Overview](#overview)  
2. [Topics Covered](#topics-covered)  
3. [Learning Objectives](#learning-objectives)  
4. [Implementation Details](#implementation-details)  
   - [Conditional Expressions](#conditional-expressions)  
   - [Dynamic Blocks](#dynamic-blocks)  
   - [Splat Expressions](#splat-expressions)  
5. [Code Examples](#code-examples)  
6. [Benefits](#benefits)  
7. [Best Practices](#best-practices)  
8. [Next Steps](#next-steps)  
9. [References](#references)  

---

## Overview
Terraform expressions are a powerful way to write reusable and dynamic infrastructure code. Instead of repeating blocks of code for different environments or resources, expressions allow us to create logic, loops, and list manipulations directly in Terraform configuration.  

This project demonstrates three essential Terraform expressions:  

- **Conditional Expressions** – Evaluate true/false conditions to set resource attributes dynamically.  
- **Dynamic Blocks** – Create repeatable nested blocks based on variable collections.  
- **Splat Expressions** – Retrieve multiple attribute values efficiently from lists of resources.  

All examples are implemented using **AWS resources**, primarily **EC2 instances** and **Security Groups**, to demonstrate real-world infrastructure scenarios.

---

## Topics Covered
- Conditional Expressions – Make decisions in Terraform configurations.  
- Dynamic Blocks – Automate nested block creation for repetitive structures.  
- Splat Expressions – Extract values from multiple resources efficiently.  

---

## Learning Objectives
By the end of this repository, you will be able to:  

- Master conditional expressions for environment-specific configurations.  
- Use dynamic blocks to eliminate repetitive resource definitions.  
- Apply splat expressions to collect attributes from multiple resources.  
- Combine expression types for powerful and flexible Terraform configurations.  
- Write cleaner, scalable, and maintainable Terraform code.  

---

## Implementation Details

### Conditional Expressions
**Purpose:**  
Conditional expressions allow Terraform to evaluate a boolean condition and return one of two values, similar to a ternary operator in programming languages.  

**Syntax:**  
```hcl
condition ? true_value : false_value
````

**Example Use Case:**
Select an EC2 instance type based on environment:

```hcl
variable "environment" {
  type    = string
  default = "dev"
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"

  tags = {
    Name = "example-${var.environment}"
  }
}
```

**Benefits:**

* Environment-based resource customization.
* Reduces code duplication.
* Simplifies configuration management.

---

### Dynamic Blocks

**Purpose:**
Dynamic blocks allow Terraform to generate multiple nested blocks dynamically based on a collection (list or map).

**Syntax:**

```hcl
dynamic "block_name" {
  for_each = var.collection
  content {
    # block configuration using each.key or each.value
  }
}
```

**Example Use Case:**
Create multiple Security Group ingress rules dynamically:

```hcl
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Security group with dynamic rules"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
```

**Benefits:**

* Eliminates repetitive code.
* Makes adding/removing rules easier.
* Supports variable-driven configurations.

---

### Splat Expressions

**Purpose:**
Splat expressions extract specific attribute values from a list of resources using a single concise expression.

**Syntax:**

```hcl
resource_list[*].attribute_name
```

**Example Use Case:**
Retrieve all EC2 instance IDs created using a `count` or `for_each`:

```hcl
resource "aws_instance" "example" {
  count = 3
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}

output "instance_ids" {
  value = aws_instance.example[*].id
}
```

**Benefits:**

* Collects multiple values efficiently.
* Useful for outputs or passing attributes to other resources.

---

## Code Examples

* Conditional Expressions – `main.tf`
* Dynamic Blocks – `security_group.tf`
* Splat Expressions – `outputs.tf`

All examples are fully implemented and tested in my AWS environment.

---

## Benefits

* Reduces repeated code.
* Makes infrastructure scalable and modular.
* Simplifies environment-specific configurations.
* Improves readability and maintainability.

---

## Best Practices

* Use descriptive iterator names in dynamic blocks.
* Keep expressions simple and readable.
* Validate variables to ensure correct data structure.
* Combine expression types for optimized configuration.
* Avoid deeply nested dynamic blocks to prevent complexity.

---

## References

* [Terraform Conditional Expressions](https://www.terraform.io/language/expressions/conditionals)
* [Terraform Dynamic Blocks](https://www.terraform.io/language/expressions/dynamic-blocks)
* [Terraform Splat Expressions](https://www.terraform.io/language/expressions/splat)
* AWS Terraform Day 10 Video Series by Piyush

```

```
