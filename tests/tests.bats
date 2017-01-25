@test "Opening Semaphore." {
  run curl --fail --insecure https://localhost/
  [ "${status}" -eq 0 ]
}

@test "Logging in to Semaphore." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"auth":"semaphore","password":"semaphore"}' https://localhost/api/auth/login --cookie-jar cookies.txt
  [ "${status}" -eq 0 ]
}

@test "Creating \"My User\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"username":"myuser","name":"My User","email":"myuser@example.com"}' --cookie cookies.txt https://localhost/api/users
  [ "${status}" -eq 0 ]
}

@test "Creating \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Project"}' --cookie cookies.txt https://localhost/api/projects
  [ "${status}" -eq 0 ]
}

@test "Adding \"My User\" to the team in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"username":"myuser","name":"My User","email":"myuser@example.com","user_id":2}' --cookie cookies.txt https://localhost/api/project/1/users
  [ "${status}" -eq 0 ]
}

@test "Creating \"My SSH Key\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My SSH Key","type":"ssh","key":"My public data","secret":"My private data"}' --cookie cookies.txt https://localhost/api/project/1/keys
  [ "${status}" -eq 0 ]
}

@test "Creating \"My Inventory\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Inventory","ssh_key_id":1,"type":"static"}' --cookie cookies.txt https://localhost/api/project/1/inventory
  [ "${status}" -eq 0 ]
}

@test "Creating \"My Environment\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Environment","json":"{}"}' --cookie cookies.txt https://localhost/api/project/1/environment
  [ "${status}" -eq 0 ]
}

@test "Creating \"My Playbook Repository\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Playbook Repository","git_url":"git@github.com:robertdebock/ansible.git","ssh_key_id":1}' --cookie cookies.txt https://localhost/api/project/1/repositories
  [ "${status}" -eq 0 ]
}

@test "Creating \"My Task Template\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"alias":"My Task Template","environment_id":1,"inventory_id":1,"playbook":"play.yml","repository_id":1,"ssh_key_id":1}' --cookie cookies.txt https://localhost/api/project/1/templates
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My Task Template\" in \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1/templates/1
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My Playbook Repository\" in \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1/repositories/1
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My Environment\" in \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1/environment/1
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My Inventory\" in \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1/inventory/1
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My SSH Key\" in \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1/keys/1
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My User\" from the team in \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1/users/2
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My Project\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/project/1
  [ "${status}" -eq 0 ]
}

@test "Deleting \"My User\"." {
  run curl --fail --insecure --request DELETE --cookie cookies.txt https://localhost/api/users/2
  [ "${status}" -eq 0 ]
}

@test "Logging out of Semaphore." {
  run curl --fail --insecure https://localhost/auth/logout
  [ "${status}" -eq 0 ]
}

@test "Removing cookies.txt" {
  run test -f cookies.txt && rm cookies.txt
}
