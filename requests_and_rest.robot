### pip install --upgrade robotframework-requests

*** Settings ***
Library         RequestsLibrary             WITH NAME   req
Library         Collections
Library         json
Suite setup     Create Session  typicode    https://jsonplaceholder.typicode.com
Suite teardown  Delete all sessions


*** Test Cases ***
requests: Should have a name and belong to a company with a slogan
  ${resp}=        req.Get Request           typicode              /users/1
  Should Be Equal As Integers               ${resp.status_code}   200
  ${name}=        Get From Dictionary       ${resp.json()}        name
  Should Be Equal As Strings                ${name}               Leanne Graham
  ${co}=          Get From Dictionary       ${resp.json()}        company
  ${co_slogan}=   Get From Dictionary       ${co}                 catchPhrase
  Should Be Equal As Strings  ${co_slogan}  Multi-layered client-server neural-net
  ${json}=        Dumps                     ${resp.json()}        indent=${4}
  Log to Console  ${json}



### pip install --upgrade RESTinstance

*** Settings ***
Library         REST              https://jsonplaceholder.typicode.com


*** Test Cases ***
RESTinstance: Should have a name and belong to a company with a slogan
    REST.GET    /users/1
    Integer     response status   200
    String      $.name            Leanne Graham
    String      $..catchPhrase    Multi-layered client-server neural-net
    Output      $
