# Robot Framework for APIs

This is a demo on using Robot Framework
[RESTinstance](https://github.com/asyrjasalo/RESTinstance)
for API (test) automation.

## Background

### robotframework-requests is great

But it takes a lot of keywords to test JSON APIs, even for simple things:

```robot
*** Settings ***
Library         RequestsLibrary
Library         Collections
Suite setup     Create Session  typicode  https://jsonplaceholder.typicode.com
Suite teardown  Delete all sessions


*** Test Cases ***
GET with robotframework-requests
  ${resp}=        Get request           typicode              /users/1
  Should Be Equal As Integers           ${resp.status_code}   200
  ${name}=        Get From Dictionary   ${resp.json()}        name
  Should Be Equal As Strings            ${name}               Leanne Graham
  Log to Console  ${resp.json()}

```

### pip install --upgrade RESTinstance

The same as above

```robot
*** Settings ***
Library         REST              https://jsonplaceholder.typicode.com

*** Test Cases ***
GET with RESTinstance
    GET         /users/1
    Integer     response status   200
    String      $.name            Leanne Graham
    Output
```
