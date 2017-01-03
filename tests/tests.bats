@test "Opening Semaphore." {
  run curl --insecure https://localhost/
  [ "${status}" -eq 0 ]
}
