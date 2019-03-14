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
