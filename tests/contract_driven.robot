*** Settings ***
Library       REST   https://jsonplaceholder.typicode.com/
...           spec=${CURDIR}/specs/openapi.yaml


*** Test Cases ***
Valid GET to single
  GET         /users/1

Valid GET to many
  GET         /users

Valid POST
  POST        /users               ${CURDIR}/payloads/new.json

Valid PUT to existing
  PUT         /users/2             { "name": "bar" }

Valid PATCH to existing
  PATCH       /users/3             { "name": "foo" }

Valid DELETE to existing
  DELETE      /users/4
