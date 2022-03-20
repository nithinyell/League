### Architecture Challenge

# Table of Contents
1. [Agenda](#agenda)
2. [Approach](#approach)
3. [User Interface](#user-interface)
4. [Web Services](#web-services)
5. [Design Patterns](#design-patterns)
6. [Components](#components)
7. [Models](#models)
8. [Class Interaction](#class-interaction)
9. [Libraries](#libraries)

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
Client Server Interaction
<img width="660" alt="Client Server Interaction" src="https://user-images.githubusercontent.com/18254027/159159207-2bdab2b2-d518-4733-a7ab-6de1433ee14a.png">

* getAccessToken(): fetch access tokeen for specific user
* getClaims(): fetch list of user claims
* getClaim?userid=12345(): fetch specific claim of user with help of query param
* getDocuments(): fetch list of user documeents
* getDocument?userid=12345(): fetch specific document of user with help if query param
* submitClaim(): post new claim
* uploadNewDocunemt(): post new document data i.e imagee data (multipart/form-data)
---

## Design Patterns

---

## Components

---

## Models

---

## Class Interaction

---

## Libraries

---
