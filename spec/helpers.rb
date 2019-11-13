# frozen_string_literal: true

module Helpers
  def configuration_with_slaves
    YAML.safe_load(<<~YAML)
      adapter: sqlite3
      database: spec/test.sqlite
      encoding: utf-8
      multidb:
        databases:
          slave1:
            database: spec/test-slave1.sqlite
          slave2:
            database: spec/test-slave2.sqlite
          slave3:
            - database: spec/test-slave3-1.sqlite
            - database: spec/test-slave3-2.sqlite
          slave_alias:
            database: spec/test-slave2.sqlite
            alias: slave2
    YAML
  end
end
