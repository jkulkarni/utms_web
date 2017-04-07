class AddStudentNameToTranscriptApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :transcript_applications, :student_name, :string
  end
end
