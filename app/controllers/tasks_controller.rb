class TasksController < ApplicationController
  load_and_authorize_resource #autorizo (enlace con el ability de cancan)
  
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  #aqui muestra todas la tareas (filtrado para que se muestre a quien sea necesario)
  #join hace consulta en memoria con task y participant
  #si la tarea le pertenece a nuestro le permite mostrar asi como participante
  #owner_id/particpants.user_id -> current_user.id //groupby para que no haya duplicado
  def index
    @tasks = Task.joins(:participants).where(
      'owner_id = ? OR particpants.user_id = ?',
      current_user.id,
      current_user.id,
    ).group(:id)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.owner = current_user #usuario actual (antes de guardarlo)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    #verificador de informacion(se crea cuando se creo el scaffolds)
    def task_params
      params.require(:task).permit(
        :name,
        :descripction,
        :due_date,
        :category_id,
        #relacion con participating
        participating_users_attributes: [
          :user_id,
          :role,
          :id,
          :_destroy#permite destruir el participante
       ]
      )
    end
end
