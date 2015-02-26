Coordinator.config.in_memory_db.create_table(:workers) do
  String :shards
  String :location
  String :software
  String :ver
  String :pc
  String :dns
  String :freedisk
  DateTime :last_seen

  primary_key [ :shards, :location ]
end
