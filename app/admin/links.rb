ActiveAdmin.register Link do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
#

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  action_item :start_job, only: :index do
    link_to "Start Job", start_job_admin_links_path
  end

  collection_action :start_job, title: "Start Scraping"  do
    # Nothing here. We just want to render the form.

  end

  collection_action :start_worker, title: "worker", method: :post do
    ScrapWorker.perform_async(params[:data][:start_page],params[:data][:end_page])
    redirect_to admin_dashboard_path
  end

end
