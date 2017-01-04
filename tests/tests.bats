@test "Opening Semaphore." {
  run curl --fail --insecure https://localhost/
  [ "${status}" -eq 0 ]
}

@test "Removing cookies.txt" {
  run test -f cookies.txt && rm cookies.txt
}

@test "Logging in to Semaphore." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"auth":"semaphore","password":"semaphore"}' https://localhost/api/auth/login --cookie-jar cookies.txt
  [ "${status}" -eq 0 ]
}

@test "Making \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Project"}' --cookie cookies.txt https://localhost/api/projects
  [ "${status}" -eq 0 ]
}

@test "Making \"My SSH Key\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My SSH Key","type":"ssh","key":"My public data","secret":"My private data"}' --cookie cookies.txt https://localhost/api/project/1/keys 
  [ "${status}" -eq 0 ]
}

@test "Making \"My Inventory\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Inventory","ssh_key_id":1,"type":"static"}' --cookie cookies.txt https://localhost/api/project/1/inventory
  [ "${status}" -eq 0 ]
}

@test "Making \"My Environment\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Environment","json":"{}"}' --cookie cookies.txt https://localhost/api/project/1/environment
  [ "${status}" -eq 0 ]
}

@test "Making \"My Playbook Repository\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"name":"My Playbook Repository","git_url":"git@github.com:user/repo.git","ssh_key_id":1}' --cookie cookies.txt https://localhost/api/project/1/repositories
  [ "${status}" -eq 0 ]
}

@test "Making \"My Task Template\" in \"My Project\"." {
  run curl --fail --insecure --request POST --header "Content-Type: application/json" --data '{"alias":"My Task Template","environment_id":1,"inventory_id":1,"playbook":"play.yml","repository_id":1,"ssh_key_id":1}' --cookie cookies.txt https://localhost/api/project/1/templates
  [ "${status}" -eq 0 ]
}

@test "Logging out of Semaphore." {
  run curl --fail --insecure https://localhost/auth/logout
  [ "${status}" -eq 0 ]
}
