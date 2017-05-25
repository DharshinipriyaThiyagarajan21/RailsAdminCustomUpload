require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
require 'simple-spreadsheet'
module RailsAdminRoutesupload
end
module RailsAdmin
  module Config
    module Actions
      class Routesupload < RailsAdmin::Config::Actions::Base
        register_instance_option :link_icon do
          'icon-th-large'
        end
        register_instance_option :member do
          false
        end
        register_instance_option :collection do
          true
        end
        register_instance_option :http_methods do
          [:get, :post]
        end
         register_instance_option :controller do
          Proc.new do
           if request.post?
           file = params[:file]['file_xls'].tempfile.path
           read_file=params[:file][:file_xls].original_filename

            file_extention=read_file.split(".").last
            temp_file = File.open('tmp/sample.'+file_extention,'w'){|f| f.write(File.read(file)) }
            read_file = SimpleSpreadsheet::Workbook.read('tmp/sample.'+file_extention)
            read_file = SimpleSpreadsheet::Workbook.read(file)
             read_file.first_row.upto(read_file.last_row-1) do |line|
              data1 = read_file.cell(line+1, 1)
              data2 = read_file.cell(line+1, 2)
              data3 = read_file.cell(line+1, 3)
              data4 = read_file.cell(line+1, 4)
              data5 = read_file.cell(line+1, 5)
              data6 = read_file.cell(line+1, 6)
               User.create(user:data1,steps:data2,distance:data3,exercise:data4,sleep:data5,calories:data6)
              end 
          
            
          end
        end
      end
    end
  end
end
end