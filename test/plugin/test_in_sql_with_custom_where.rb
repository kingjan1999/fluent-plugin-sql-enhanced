require "helper"
require "fluent/test/driver/input"

class SqlInputCustomWhereTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def teardown
  end

  CONFIG = %[
    adapter postgresql
    host localhost
    port 5432
    database fluentd_test

    username fluentd
    password fluentd

    schema_search_path public

    tag_prefix db

    <table>
      table messages_custom_time
      tag logs
      update_column updated_at
      where_condition message = 'message 3'
    </table>
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::SQLEnhancedInput).configure(conf)
  end

  def test_configure
    d = create_driver
    expected = {
      host: "localhost",
      port: 5432,
      adapter: "postgresql",
      database: "fluentd_test",
      username: "fluentd",
      password: "fluentd",
      schema_search_path: "public",
      tag_prefix: "db"
    }
    actual = {
      host: d.instance.host,
      port: d.instance.port,
      adapter: d.instance.adapter,
      database: d.instance.database,
      username: d.instance.username,
      password: d.instance.password,
      schema_search_path: d.instance.schema_search_path,
      tag_prefix: d.instance.tag_prefix
    }
    assert_equal(expected, actual)
    tables = d.instance.instance_variable_get(:@tables)
    assert_equal(1, tables.size)
    messages_custom_time = tables.first
    assert_equal("messages_custom_time", messages_custom_time.table)
    assert_equal("logs", messages_custom_time.tag)
  end

  def test_message
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    d = create_driver(CONFIG + "select_interval 1")

    Message.create!(message: "message 1",)
    Message.create!(message: "message 2")
    Message.create!(message: "message 3")

    d.end_if do
      d.record_count >= 1
    end
    d.run(timeout: 5)

    assert_equal("db.logs", d.events[0][0])

    assert_equal(1, d.record_count)
    assert_equal("message 3", d.events[0][2]["message"])
  end

  class Message < ActiveRecord::Base
    self.table_name = "messages_custom_time"
  end
end
