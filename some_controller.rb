class SomeController < ApplicationController
  def show_candidates
    @open_jobs = Job.all_open_new(current_user.organization)
   if current_user.has_permission?('view_candidates')
     @candidates = current_user.organization.candidates.where(is_deleted: false, is_completed: true)
   else
     # this query is a bit of guess work. It really depends on the relationships between the models which I can't see
     # also its pretty complex, which means its hard to eyeball
      @candidates = Candidate.where(is_completed: true, is_deleted: false, organization_id: current_user.organization_id).includes(candidate_jobs: {jobs: :job_contacts}).where('jobs.is_deleted' => false, 'job_contact.user_id' => current_user.id)
    end
    if params[:sort] == 'Candidates Newest -> Oldest'
      @candidates = @candidates.order(created_at: :desc)
    elsif params[:sort] == 'Candidates Oldest -> Newest'
      @candidates = @candidates.order(:created_at)
    elsif params[:sort] == 'Candidates A -> Z'
      @candidates =  @candidates.order(last_name: :asc, created_at: :asc)
    elsif params[:sort] == 'Candidates Z -> A'
      @candidates = @candidates.order(last_name: :desc, created_at: :asc)
    end
    render :partial => "candidates_list", :locals => { :@candidates => @candidates, :open_jobs => @open_jobs }, :layout => false
  end
end
