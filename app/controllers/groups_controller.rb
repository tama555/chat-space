class GroupsController < ApplicationController

  def index
  end

  def new
    @group = Group.new
    @group.users << current_user     #配列に要素を追加するためのもの#ChatSpaceの仕様として、グループを新規作成する時はログイン中のユーザーを必ず含めたいためあらかじめ追加しておきます。
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new   #redirect_toの場合は、新たなリクエストがされたのと同じ動きになりますので、コントローラーを経由してビューが表示されます。それに対してrenderの場合はそのままビューが表示されます。これによって、元のインスタンス変数の値が上書きされるかどうかが違います。今回は、@groupが保存されなかった場合に、フォームに入力した内容を保持したままグループ作成画面を表示するという処理になります。
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])  #ストロングパラメータの部分に注目しましょう。user_ids: []」という記述があります。このように、配列に対して保存を許可したい場合は、キーの名称と関連づけてバリューに「[]」と記述します。
  end

end