## Project Documentation

This repository contains the documentation for the CAP Update December 2025 project.

### Overview
This project consists of all information regarding the new features from the SAP CAP December 2025 update. The features that have been implemented inside are status-transition flow and declarative constraints.

### Implemented Features

#### Status-Transition Flow
Status-transition flows ensure transitions are explicitly modeled, validated, and executed in a controlled and reliable way, thereby eliminating the need for extensive custom coding.

#### Declarative Constraints
Declarative constraints allow you to express conditions using CDS Expression Language (CXL) that are validated automatically whenever data is written. This greatly reduces the need for extensive custom code for input validation.


> **Note:** Don't confuse declarative constraints as discussed in here with database constraints. Declarative constraints are meant for domain-specific input validation with error messages meant to be shown to end users, while database constraints are meant to prevent data corruption due to programming error, with error messages not intended for end users.

### Usage
To test the SAP CAP Java Project, you need to make sure all of the prerequisite software has been installed.

Then, run these command lines to generate the data.

```bash
cd cap_update_december_2025
npm install
cds deploy
mvn clean install
mvn spring-boot:run
```

The API documentation is available at:

- [CAP Documentation](https://cap.cloud.sap/docs/)

### Contributing
Guidelines for contributing to this project.

### License
Include license information here.
