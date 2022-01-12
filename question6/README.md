# Development environment
```bash
terraform --version
Terraform v1.1.2
on linux_amd64
```

# Possible Improvements
Different resources should be created from different modules this will make individual modules as generic as possible , this will make modules more flexible, maintainable and reusable. As a side effect we could use this modules on other module or on a terraform workspace to manage multiple user belonging to the same group, multiple policies attached to the same role, and so on. 
This would be a better approach to managing the environment for a whole organization/project rather than for a problem as simple as this question.

Given more time, a good practice would be to develop tests using the experimental feature [terraform test](https://www.terraform.io/language/modules/testing-experiment) to ensure every resource is creasted as expected.