Sequel.migration do
  change do
    create_table(:tests) do
      primary_key :id
      String :params
      String :images
      String :results
      DateTime :created_at
      DateTime :started_at
      DateTime :completed_at
    end
  end
end
