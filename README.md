# Robot Framework for APIs

This is a demo on using Robot Framework
[RequestsLibrary](https://github.com/bulkan/robotframework-requests) and
[RESTinstance](https://github.com/asyrjasalo/RESTinstance)
for API (test) automation.

We are using [JSONPlaceholder](https://jsonplaceholder.typicode.com/users)
as the system under test in these examples.

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


## Towards model-based testing: Properties matter, values do not

Let's move the logic from tests to JSON Schemas.

Our original goal was to enable tests that are three lines at maximum:

```robot
*** Settings ***
Library         REST   https://jsonplaceholder.typicode.com
Suite setup     Expect response body      ${CURDIR}/model.json

*** Test Cases ***
Valid user
    GET         /users/1
    String      $.email       format=email

New user
    POST        /users        ${CURDIR}/user.json

Edit user
    PUT         /users/1      ${CURDIR}/user.json

Edit email
    PATCH       /users/2      { "email": "ismo.aro@robotframework.dev" }

Delete
    [Setup]     Expect response body      { "required": [] }
    DELETE      /users/10
    [Teardown]  Clear expectations

Valid users
    GET         /users
    Array       $             minItems=1    maxItems=10
    Integer     $[*].id       maximum=10
```


## Towards contract-driven testing: From JSON Schemas to OpenAPI specifications

But as usual, we decided to challenge ourselves a bit: As JSON Schema is
a subset of OpenAPI/Swagger, why not include the allowed HTTP operations there?

So, one line should be enough. For everyone:

```robot
*** Settings ***
Library         REST   https://jsonplaceholder.typicode.com
...             spec=${CURDIR}/contract.json

*** Test Cases ***
Valid user
    GET         /users/1

New user
    POST        /users        ${CURDIR}/user.json

Edit user
    PUT         /users/1      ${CURDIR}/user.json

Edit email
    PATCH       /users/2      { "email": "ismo.aro@robotframework.dev" }

Delete
    DELETE      /users/10

Valid users
    GET         /users


```

By the way, this covers the all the possible users the API might ever handle.

REST your mind, OSS got your back.
