require 'rubygems'
require 'bundler'
Bundler.require

class Stream < Goliath::API

  def on_close(env)
    env.logger.info "Connection closed."
  end

  def response(env)
    keepalive = EM.add_periodic_timer(1) do
      env.stream_send("#{Time.now.strftime("%a, %e %b %Y %H:%M:%S")}\n")
    end

    [200, {'Content-Type' => 'text/plain'}, Goliath::Response::STREAMING]
  end
end
