*** Settings ***
Library         REST   https://jsonplaceholder.typicode.com/
Test setup      Expect response body      ${CURDIR}/model.json


*** Test Cases ***
Valid GET to single
  GET        /users/1
  String     response body name   Leanne Graham
  String     $..lat               -37.3159
  Integer    response status      200

Valid GET to many
  Expect response body            { "type": "array" }
  GET        /users
  String     $[*].name            pattern=[A-Z][a-z]+ [A-Z][a-z]+
  String     $[*].email           format=email
  Integer    $[*].id              minimum=1     maximum=10
  Integer    response status      200

Valid POST
  Expect response body            { "required": ["id", "name"] }
  POST       /users               { "id": 10, "name": "Ismo Aro" }
  Integer    response status      201

Valid PUT to existing
  Expect response body            { "required": ["name"] }
  PUT        /users/2             { "name": "bar" }
  Integer    response status      200

Valid PATCH to existing
  PATCH      /users/3             { "name": "foo" }
  Integer    response status      200

Valid DELETE to existing
  Expect response body            { "required": [] }
  DELETE     /users/10
  Integer    response status      200
