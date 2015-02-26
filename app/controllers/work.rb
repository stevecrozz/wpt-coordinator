class WorkController < Sinatra::Base
  get '/work/getwork.php' do
    Worker.heartbeat(params)

    test = Test.where(completed_at: nil).first
    test.started_at = Time.now
    test.save

    run = <<-EOF
Test ID=#{test.id}
url=http://lithostech.com
fvonly=1
tcpdump=1
Capture Video=1
runs=1
bwIn=0
bwOut=0
latency=0
plr=0
browser=Chrome
orientation=default
    EOF

    halt 200, {'Content-Type' => 'text/plain'}, run
  end

  post '/work/resultimage.php' do
    key = File.join('tests', params[:id], params[:file][:filename])

    Coordinator.config.fog_directory.files.create(
      key: key,
      body: params[:file][:tempfile])

    image = {
      key: key,
      run: params[:run],
      index: params[:index],
      cached: params[:cached]
    }

    test = Test.where(id: 1).first
    test.images ||= []
    test.images << image

    JSON.pretty_generate(image)
  end

  get '/workers' do
    content_type :json
    workers = Worker.map(&:values)
    JSON.pretty_generate(workers)
  end

  post '/tests' do
    test = Test.new
    test.created_at = Time.now
    test.save
    JSON.pretty_generate(test.values)
  end
end
