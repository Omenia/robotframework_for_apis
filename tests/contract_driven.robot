*** Settings ***
Library       REST   https://jsonplaceholder.typicode.com/
...           spec=${CURDIR}/contract.yaml


*** Test Cases ***
Valid GET to single
  GET         /users/5

Valid GET to many
  GET         /users

Valid POST
  POST        /users               { "id": 100, "name": "Ismo Aro" }

Valid PUT to existing
  PUT         /users/6             { "name": "bar" }

Valid PATCH to existing
  PATCH       /users/7             { "name": "foo" }

Valid DELETE to existing
  DELETE      /users/100
