# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120807034325) do

  create_table "bogota", :id => false, :force => true do |t|
    t.integer "Sales Organization",       :null => false
    t.integer "Distribution Channel ID",  :null => false
    t.integer "Sector",                   :null => false
    t.date    "Invoice Date",             :null => false
    t.integer "Client ID",                :null => false
    t.text    "Client name",              :null => false
    t.integer "Salesperson ID",           :null => false
    t.text    "Salesperson name",         :null => false
    t.integer "Invoice",                  :null => false
    t.date    "Delivery Date",            :null => false
    t.integer "Shipment Document no."
    t.integer "SKU",                      :null => false
    t.integer "Location",                 :null => false
    t.float   "Ordered Quantity",         :null => false
    t.integer "Net Price",                :null => false
    t.float   "Delivery Quantity",        :null => false
    t.float   "Delta Ordered - Delivery", :null => false
    t.text    "UOM",                      :null => false
    t.text    "Currency",                 :null => false
    t.float   "Cartons",                  :null => false
    t.float   "Equivalent Cartons",       :null => false
    t.integer "Net price delivered",      :null => false
    t.text    "Client Group",             :null => false
    t.float   "Return Quantity",          :null => false
    t.integer "Returned Price",           :null => false
    t.integer "Net Price after returns",  :null => false
    t.integer "Sales Area",               :null => false
    t.float   "Net Quantity",             :null => false
    t.float   "Net Cartons",              :null => false
    t.text    "DC",                       :null => false
    t.text    "Route ID",                 :null => false
    t.integer "Rejected ID"
    t.text    "Rejection description",    :null => false
    t.integer "City code",                :null => false
  end

  add_index "bogota", ["Client ID"], :name => "bogota_client_id"
  add_index "bogota", ["Client ID"], :name => "idx_clientid"
  add_index "bogota", ["Ordered Quantity"], :name => "idx_ordered quantity"
  add_index "bogota", ["Ordered Quantity"], :name => "idx_orderedquantity"
  add_index "bogota", ["Ordered Quantity"], :name => "orderedquantity_idx"

  create_table "bogota_aggregate", :id => false, :force => true do |t|
    t.integer "count",     :limit => 8, :default => 0, :null => false
    t.integer "month"
    t.integer "year"
    t.integer "client_id",                             :null => false
  end

  create_table "clients", :id => false, :force => true do |t|
    t.text    "Sales Zone",      :null => false
    t.integer "Client ID",       :null => false
    t.text    "Client ID 2",     :null => false
    t.text    "Client Name 1",   :null => false
    t.text    "Client Name 2",   :null => false
    t.text    "Address"
    t.text    "Phone",           :null => false
    t.text    "Invoice ID"
    t.integer "Sales Office ID"
    t.text    "Town",            :null => false
    t.text    "Town Class",      :null => false
    t.text    "Client Group",    :null => false
    t.integer "DC",              :null => false
    t.text    "Channel",         :null => false
    t.text    "Urban Flag",      :null => false
    t.text    "Sales Type",      :null => false
    t.integer "?",               :null => false
    t.text    "Special Status"
    t.text    "??",              :null => false
    t.integer "???"
    t.text    "District"
    t.text    "Transport Area",  :null => false
    t.integer "Transport Hub"
    t.text    "Field 4"
    t.date    "Date",            :null => false
    t.integer "Credit Limit",    :null => false
  end

  add_index "clients", ["Client ID"], :name => "idx_clients_client_id"

  create_table "clients_distances", :id => false, :force => true do |t|
    t.integer "client_1_id", :null => false
    t.integer "client_2_id", :null => false
    t.float   "distance"
    t.float   "time"
  end

  add_index "clients_distances", ["client_1_id", "client_2_id"], :name => "clients_distance_1_2", :unique => true

  create_table "corrected_addresses", :id => false, :force => true do |t|
    t.integer "ClientID",         :null => false
    t.integer "ClientName",       :null => false
    t.text    "Address",          :null => false
    t.text    "Town",             :null => false
    t.text    "Country",          :null => false
    t.text    "CorrectedAddress", :null => false
    t.float   "MarcoLatitude",    :null => false
    t.float   "MarcoLongtitude",  :null => false
    t.float   "Latitude"
    t.float   "Longtitude"
  end

  create_table "distance_for_clients", :primary_key => "client_id", :force => true do |t|
  end

  create_table "join_table", :id => false, :force => true do |t|
    t.integer "Client ID",                      :null => false
    t.text    "Client name 1"
    t.integer "SKU",                            :null => false
    t.integer "No. of SKU",                     :null => false
    t.float   "Sum of Ordered Quantity",        :null => false
    t.float   "Sum of Delivery Quantity",       :null => false
    t.float   "Sum of Return Quantity",         :null => false
    t.float   "Rejected ID"
    t.float   "Sum of Net Cartons",             :null => false
    t.float   "Sum of Net price delivered",     :null => false
    t.float   "Sum of Net Price after returns", :null => false
    t.integer "DC"
    t.text    "Channel"
    t.text    "Town"
  end

  add_index "join_table", ["Client ID"], :name => "idx_clientid"
  add_index "join_table", ["SKU"], :name => "idx_SKU"

  create_table "main_table", :id => false, :force => true do |t|
    t.integer "Client ID",                      :null => false
    t.integer "SKU",                            :null => false
    t.integer "No. of SKU",                     :null => false
    t.float   "Sum of Ordered Quantity",        :null => false
    t.float   "Sum of Delivery Quantity",       :null => false
    t.float   "Sum of Return Quantity",         :null => false
    t.float   "Rejected ID"
    t.float   "Sum of Net price delivered",     :null => false
    t.float   "Sum of Net Price after returns", :null => false
    t.float   "Sum of Net Cartons",             :null => false
  end

  add_index "main_table", ["Client ID"], :name => "bogota_client_id"
  add_index "main_table", ["Client ID"], :name => "idx_clientid"
  add_index "main_table", ["SKU"], :name => "idx_SKU"

  create_table "products", :id => false, :force => true do |t|
    t.integer "SKU",                :null => false
    t.text    "SKU Description",    :null => false
    t.text    "UOM 1",              :null => false
    t.text    "UOM 2",              :null => false
    t.integer "Item Group",         :null => false
    t.text    "Old SKU",            :null => false
    t.integer "Item Class"
    t.integer "????",               :null => false
    t.integer "?????",              :null => false
    t.float   "UPC Code"
    t.integer "Items per Unit",     :null => false
    t.integer "Currency ID",        :null => false
    t.float   "Weight",             :null => false
    t.text    "Weight Units",       :null => false
    t.float   "Cube",               :null => false
    t.text    "Cube Units",         :null => false
    t.float   "Gross Weight",       :null => false
    t.text    "Units Gross Weight", :null => false
  end

  add_index "products", ["SKU"], :name => "idx_products_sku"

end
