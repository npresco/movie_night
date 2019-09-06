# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

# Turns on prometheus reporting
require_relative "config/environment"
require 'prometheus/client'

use Yabeda::Prometheus::Exporter

run Rails.application
