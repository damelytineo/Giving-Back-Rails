class PhilanthropicInitiativesController < ApplicationController
    before_action :set_philanthropic_initiative, :logged_in

    def index
        @philanthropic_initiatives = PhilanthropicInitiative.all
    end

    def new 
        correct_business
        
        @philanthropic_initiative = PhilanthropicInitiative.new(business_id: params[:business_id])
        @philanthropic_initiative.build_beneficiary
    end

    def create 
        #correct_business
        
        @philanthropic_initiative = PhilanthropicInitiative.create(philanthropic_initiative_params) 
        if @philanthropic_initiative.save
            redirect_to philanthropic_initiatives_path
        else 
            render 'new'
        end
    end

    def show 
    end

    def edit 
        correct_business
    end

    def update 
        #correct_business   
        
        @philanthropic_initiative.update(philanthropic_initiative_params)
        if @philanthropic_initiative.save
            redirect_to philanthropic_initiative_path(@philanthropic_initiative)
        else 
            render 'edit'
        end
    end

    def destroy
        correct_business

        @beneficiary = @philanthropic_initiative.beneficiary 
        @philanthropic_initiative.delete
        @beneficiary.delete

        # redirect_to business_path(current_business) 
    end
    
    private
    def philanthropic_initiative_params
        params.require(:philanthropic_initiative).permit(:name, :pledged_amount, :goal, :business_id, beneficiary_attributes: [:recipient, :city, :state])
    end

    def set_philanthropic_initiative
        @philanthropic_initiative = PhilanthropicInitiative.find_by(id: params[:id]) 
    end

    def correct_business
        if current_business.id != params[:business_id].to_i
            redirect_to root_path
        end
    end
end

    
