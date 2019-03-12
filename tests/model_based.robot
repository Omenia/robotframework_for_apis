*** Settings ***
Library      REST   https://jsonplaceholder.typicode.com/
Test setup   Expect response      ${CURDIR}/schemas/one.json


*** Test Cases ***
Valid GET to single
  GET        /users/1
  String     response body name   Leanne Graham
  String     $..lat               -37.3159
  Integer    response status      200

Valid GET to many
  [Setup]    Expect response      ${CURDIR}/schemas/many.json
  GET        /users
  String     $[*].name            pattern=[A-Z][a-z]+ [A-Z][a-z]+
  String     $[*].email           format=email
  Integer    $[*].id              minimum=1     maximum=10
  Integer    response status      200

Valid POST
  POST       /users               ${CURDIR}/payloads/new.json
  Integer    response status      201

Valid PUT to existing
  PUT        /users/2             { "name": "bar" }
  Integer    response status      200

Valid PATCH to existing
  PATCH      /users/3             { "name": "foo" }
  Integer    response status      200

Valid DELETE to existing
  DELETE     /users/4
  Integer    response status      200
