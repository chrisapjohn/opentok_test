sclass RoomsController < ApplicationController
  before_filter :config_opentok,:except => [:index]

	def index
		@rooms = Room.where(:public => true).order("created_at DESC")
		@new_room = Room.new
	end

	def create
		config_opentok
		session = @opentok.create_session request.remote_addr
		params[:room][:sessionId] = session.session_id

		@new_room = Room.new(params[:room])

		respond_to do |format|
			if @new_room.save
			format.html { redirect_to("/party/"+@new_room.id.to_s) }
			else
			format.html { render :controller => "rooms",
			:action => "index" }
			end
		end
	end

	def party
		@room = Room.find(params[:id])

		@tok_token = @opentok.generate_token :session_id =>@room.sessionId 
	end

	private
	
	def config_opentok
		if @opentok.nil?
			@opentok = OpenTok::OpenTokSDK.new "44638502", "f2e75ad42d2f4624b79b5f6adf925ba65b02cf79"
		end
	end
end