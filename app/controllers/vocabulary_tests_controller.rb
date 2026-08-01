class VocabularyTestsController < ApplicationController
  before_action :score_graph, only: [ :index ]
  before_action :set_user_classroom_homeworks, only: [ :new, :create, :edit ]

  def index
    @scores = user_scores.includes(:homework)
                            .order(homework_id: :desc)
                            .page(params[:page]).per(5)
  end

  def new
    @scores = VocabularyTest.includes(:homework).order(homework_id: :desc)
    @score = VocabularyTest.new(test_date: Date.today)
    registered_homework_ids = user_scores.pluck(:homework_id) # ログイン中のユーザーがすでに登録済みの宿題IDを配列で取得
    @homeworks = @user_classroom_homeworks
                          .where.not(id: registered_homework_ids) # まだテスト結果を登録していない宿題
                          .order(created_at: :desc)
  end

  def create
    @score = user_scores.build(score_params)
    if @score.save
      redirect_to vocabulary_tests_path, notice: "単語テストを新しく記録しました。"
    else
      @scores = VocabularyTest.order(test_date: :desc, created_at: :desc)
      @homeworks = @user_classroom_homeworks.order(created_at: :desc)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @score = user_scores.find(params[:id]) # ログイン中ユーザー自身の テスト結果
    @homeworks = @user_classroom_homeworks.order(created_at: :desc)
  end

  def update
    @score = user_scores.find(params[:id])
    if @score.update(score_params)
      redirect_to vocabulary_tests_path, notice: "単語テストを更新しました。"
    else
      flash.now[:danger] = "更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @score = user_scores.find(params[:id])
    @score.destroy!
    redirect_to vocabulary_tests_path, notice: "記録を削除しました。"
  end

  private

  def score_params # 「許可したパラメータしか受け取らない」
    params.require(:vocabulary_test).permit(:vocabulary_score, :sentence_score, :test_date, :homework_id)
  end

  def score_graph
    @scores = user_scores.includes(:homework).order(homework_id: :asc)
    @score_data = [
      { name: "単語テスト", data: @scores.map { |score| [ score.homework.title, score.vocabulary_score ] } },
      { name: "文テスト", data: @scores.map { |score| [ score.homework.title, score.sentence_score ] } }
    ]
  end

  def user_scores
    current_user.vocabulary_tests
  end

  def set_user_classroom_homeworks
    @user_classroom_homeworks = Homework.where(classroom_id: current_user.classroom_id)
  end
end
