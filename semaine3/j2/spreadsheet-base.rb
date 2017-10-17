require 'bundler'
Bundler.require
 
# Authenticate a session with your Service Account
session = GoogleDrive::Session.from_service_account_key("client_secret.json")
 
# Get the spreadsheet by its title
spreadsheet = session.spreadsheet_by_title("test pour ruby gem")
# Get the first worksheet
worksheet = spreadsheet.worksheets.first
# Print out the first 6 columns of each row
worksheet.rows.each { |row| puts row.first(6).join(" | ") }






# and actions be like :
worksheet.insert_rows(2, [["Hello!", "This", "was", "inserted", "via", "Ruby"]])
worksheet.save



# You always need to save the worksheet to persist changes back to the spreadsheet. If you want to insert a row at the bottom of all existing rows, use the num_rows method.
worksheet.insert_rows(worksheet.num_rows + 1, [["Hello!", "This", "was", "inserted", "at", "the", "bottom"]])
worksheet.save


# To update a cell you can reference the cell by row and column number:
worksheet[2, 1] = "Updated!"
worksheet.save


# You can also use the cell name:
worksheet["A2"] = "Updated again!"
worksheet.save


# Deleting rows is like inserting rows, you need to provide the row number and how many rows you’d like to delete:
worksheet.delete_rows(2, 1)
worksheet.save



# Full doc :
# http://www.rubydoc.info/gems/google_drive/2.1.2/GoogleDrive/Worksheet