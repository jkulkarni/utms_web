class AddUniversityIdToTranscriptApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :transcript_applications, :university_id, :integer
  end
end
