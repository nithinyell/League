### Architecture Challenge

# Table of Contents
1. [Agenda](#agenda)
2. [Approach](#approach)
3. [User Interface](#user-interface)
4. [Web Services](#web-services)
5. [Design Patterns](#design-patterns)
7. [Data Models](#data-models)
8. [Class Interaction](#class-interaction)
9. [Backlog](#backlog)
10. [Libraries](#libraries)

## Agenda
The most important features in the League platform is the ability to manage uploads. These uploads may exist in a few different places

* Images supporting a claim, like receipts, prescriptions, doctor's note, etc.
* Personal or recurring documents, like your ID, gym membership, Beneficiary Form, etc.
* Our Customer Care team needs to be able to review these documents for accuracy in their own section of the app.
 
High level front-end architecture of new upload management system. There are a few actions to keep in mind
* The member would like to upload documents.
* The member would like to view uploaded documents.
* The member would like to add metadata to a document.
* The member may want to edit a document later.
* The member may want to delete a document.
* Submitting a claim is in a different spot in the app, but the member still needs to upload supporting documents.
* The customer care agent would like to view uploaded documents.
* The customer care agent would like to access associated documents while processing claims.

---

## Approach

* Login In & Sign Up View Controllers to authenticate
* Tab View Controller for Claims & Documeents
* Claim & Document Detail View Controllers

---

## Flow Diagram
<img width="1017" alt="App Flow" src="https://user-images.githubusercontent.com/18254027/159155866-e4aba1aa-6166-43cd-8827-b574e961d0e6.png">

---

## User Interface
<img width="626" alt="User Interface" src="https://user-images.githubusercontent.com/18254027/159158389-30780fe2-a673-4831-b624-1f058c6cfc1d.png">

---

## Web Services
Client Server Interaction - ```Amazon S3 or Azure Cloud```
<img width="660" alt="Client Server Interaction" src="https://user-images.githubusercontent.com/18254027/159159207-2bdab2b2-d518-4733-a7ab-6de1433ee14a.png">

* getAccessToken(): fetch access token for specific user
* getClaims(): fetch list of user claims
* getClaim?userid=12345(): fetch specific claim of user with help of query param
* getDocuments(): fetch list of user documents
* getDocument?userid=12345(): fetch specific document of user with help if query param
* submitClaim(): post new claim
* uploadNewDocunemt(): post new document data i.e image data (multipart/form-data)
---

## Design Patterns

MVVM is the most commonly used architecture for mobile apps. This encourages loosly coupled components and also testing would be made easy

<img width="741" alt="Architecture" src="https://user-images.githubusercontent.com/18254027/159159906-2aa4ae03-7d6e-48d1-80c8-06c5cf9e4054.png">

---

App Modules help to separate the code and ease updates/change request to apps

<img width="649" alt="App Modules" src="https://user-images.githubusercontent.com/18254027/159160147-7aa12404-8d92-4875-b64e-827eb814480d.png">

---

Interaction

<img width="795" alt="Interaction" src="https://user-images.githubusercontent.com/18254027/159160618-29f4f113-57d9-46cc-b92b-7a3173389f47.png">

---

## Data Models

Models Reference
<img width="572" alt="Data Models" src="https://user-images.githubusercontent.com/18254027/159161183-edf4202f-d777-4404-81a8-46fb60369e0b.png">

---

## Class Interaction
<img width="882" alt="Class interactor" src="https://user-images.githubusercontent.com/18254027/159164092-1fededef-cb3a-4adf-a2f2-31b707bc956f.png">

---

## Backlog
* Implement ```api pagination``` to deal with numerous claims in claims list view controller. Same should be followed for documents list
* Integrate ```encription and decription using AES scripting``` to secure the user data on mobile device
* ```SSL Pinning should be added in order to escape from middle man attacks
* Use `Xcode Profiles` to enhance the app performance
* Add ```telemetry``` and collect data to understand the user activity
* Implement ```Push Notification``` to knmow the statuc of the claims

## Libraries
Though I am a big fan of using iOS Native APIS, there are plenty open sources libraries doing amazing job
* [Alamofire](https://github.com/Alamofire/Alamofire) provided best apis to make service calls
* Cache implementation for offline data loading
---
