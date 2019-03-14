# Robot Framework for APIs

This is a demo on using Robot Framework
[RequestsLibrary](https://github.com/bulkan/robotframework-requests) and
[RESTinstance](https://github.com/asyrjasalo/RESTinstance)
for API (test) automation.

**Disclaimer:** My intentions do not include competing with already existing
good solutions: RESTinstance is targeted for JSON APIs (only) -
the two libraries are not mutually exclusive.

## Rationale

### robotframework-requests is truly great HTTP test library

But it takes a lot of keywords to test JSON APIs even for simple things:

```robot
*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         json
Suite setup     Create Session  typicode  https://jsonplaceholder.typicode.com
Suite teardown  Delete all sessions


*** Test Cases ***
requests: Should have a name and belong to a company with a slogan
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

### For JSON APIs, `pip install --upgrade RESTinstance`

Then the same as above:

```robot
*** Settings ***
Library         REST              https://jsonplaceholder.typicode.com


*** Test Cases ***
RESTinstance: Should have a name and belong to a company with a slogan
    GET         /users/1
    Integer     response status   200
    String      $.name            Leanne Graham
    String      $..catchPhrase    Multi-layered client-server neural-net
    Output      $
```

Also, enjoy the colored JSON `Output` - powered by
[pygments](http://pygments.org), thanks Georg Brandl et al.
