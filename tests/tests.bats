@test "Opening Semaphore." {
  run curl --insecure https://localhost/
  [ "${status}" -eq 0 ]
}

@test "Logging in incorrectly to Semaphore." {
  run curl --insecure https://localhost/auth/login --cookie-jar cookies.txt -F 'auth=notcorrect' -F 'password=notcorrect'
  [ "${status}" -ne 0 ]
}

@test "Logging in to Semaphore." {
  run curl --insecure https://localhost/auth/login --cookie-jar cookies.txt -F 'auth=semaphore' -F 'password=semaphore'
  [ "${status}" -eq 0 ]
}

@test "Logging out of Semaphore." {
  run curl --insecure https://localhost/api/auth/logout --cookie-jar
  [ "${status}" -eq 0 ]
}
