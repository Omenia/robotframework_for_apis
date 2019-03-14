# Robot Framework for APIs

This is a demo on using Robot Framework
[RESTinstance](https://github.com/asyrjasalo/RESTinstance)
for API (test) automation.

## Rationale

### robotframework-requests is truly great

But it takes a lot of keywords to test JSON APIs, even for simple things:

```robot
*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         json
Suite setup     Create Session  typicode  https://jsonplaceholder.typicode.com
Suite teardown  Delete all sessions


*** Test Cases ***
GET with robotframework-requests
  ${resp}=        Get request               typicode              /users/1
  Should Be Equal As Integers               ${resp.status_code}   200
  ${name}=        Get From Dictionary       ${resp.json()}        name
  Should Be Equal As Strings                ${name}               Leanne Graham
  ${co}=          Get From Dictionary       ${resp.json()}        company
  ${co_slogan}=   Get From Dictionary       ${co}                 catchPhrase
  Should Be Equal As Strings  ${co_slogan}  Multi-layered client-server neural-net
  ${json}=        Dumps                     ${resp.json()}        indent=${4}
  Log to Console  ${json}
```

### pip install --upgrade RESTinstance

The same as above:

```robot
*** Settings ***
Library         REST              https://jsonplaceholder.typicode.com


*** Test Cases ***
GET with RESTinstance
    GET         /users/1
    Integer     response status   200
    String      $.name            Leanne Graham
    String      $..catchPhrase    Multi-layered client-server neural-net
    Output      $
```

Also enjoy the colored JSON `Output` (powered by
[pygments](http://pygments.org) - thanks Georg Brandl et al.).
