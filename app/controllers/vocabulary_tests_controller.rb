class VocabularyTestsController < ApplicationController
  def index
    @new_score = VocabularyTest.new(test_date: Date.today)
    @scores = VocabularyTest.includes(:homework).order(homework_id: :desc)
    # 登録済みの宿題はリストに表示しない設定
    # pluck 指定したカラムだけを配列で取り出す
    registered_homework_ids = current_user.vocabulary_tests.pluck(:homework_id)
    @homeworks = Homework.where(classroom_id: current_user.classroom_id)
                         .where.not(id: registered_homework_ids)
  end

  def new
    VocabularyTest.new
  end

  def create
    @new_score = current_user.vocabulary_tests.build(score_params)
    if @new_score.save
      redirect_to vocabulary_tests_path, notice: "単語テストを新しく記録しました。"
    else
      @scores = VocabularyTest.order(test_date: :desc, created_at: :desc)
      @homeworks = Homework.where(classroom_id: current_user.classroom_id).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @score = current_user.vocabulary_tests.find(params[:id])
    @homeworks = Homework.where(classroom_id: current_user.classroom_id).order(created_at: :desc)
  end

  def update
    @score = current_user.vocabulary_tests.find(params[:id])
    if @score.update(score_params)
      redirect_to vocabulary_tests_path, notice: "単語テストを更新しました。"
    else
      flash.now[:danger] = "更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @score = VocabularyTest.find(params[:id])
    @score.destroy!
    redirect_to vocabulary_tests_path, notice: "記録を削除しました。"
  end

  def score_graph
    @scores = current_user.vocabulary_tests.includes(:homework).order(homework_id: :asc)
    @score_data = [
      { name: "単語テスト", data: @scores.map { |score| [ score.homework.title, score.vocabulary_score, score.sentence_score ] } },
      { name: "文テスト", data: @scores.map { |score| [ score.homework.title, score.sentence_score, score.sentence_score ] } }
    ]
  end

  private

  def score_params
    params.require(:vocabulary_test).permit(:vocabulary_score, :sentence_score, :test_date, :homework_id)
  end
end
