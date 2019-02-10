Datadog.configure do |c|
  c.use :rails, service_name: 'package-tracker'
  c.tracer hostname: ENV['DD_AGENT_PORT_8126_TCP_ADDR'],
    port: ENV['DD_AGENT_PORT_8126_TCP_PORT']
end
