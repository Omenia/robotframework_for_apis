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
    Expect response body      { "required": [] }
    DELETE      /users/10

Valid users
    Clear expectations
    GET         /users
    Array       $             minItems=1    maxItems=10
    Integer     $[*].id       maximum=10
