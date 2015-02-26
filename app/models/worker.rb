class Worker < Sequel::Model(Coordinator.config.in_memory_db)
  def self.heartbeat(params)
    shards = params.delete("shards")
    location = params.delete("location")

    worker = self.find(shards: shards, location: location)
    worker = self.new unless worker

    worker.shards = shards
    worker.location = location
    worker.last_seen = Time.now
    worker.set(params)
    worker.save
  end
end
