class TasksController < ApplicationController
  before_action :set_date, only: :index

  def index
    @classroom = current_user.classroom #　ユーザーが所属するクラス
    @homeworks = @classroom.homeworks.published.includes(:tasks).where(
      "DATE(test_start_date) <= ? AND DATE(test_end_date) >= ?",
      @selected_date,
      @selected_date
    )  # 「選択した日付」が、宿題の開始日〜終了日の範囲内に入っているものだけに絞る

    @tasks = @homeworks.flat_map(&:tasks)
  end

  private

  def set_date
    base_date = params[:week].present? ? Date.parse(params[:week]) : Date.today
    # パラメータがあればその日付を使う、入っていなければ今日の日付を使う
    week_start = base_date.beginning_of_week(:monday) # beginning_of_week = 週の開始日を返すメソッド
    week_end   = week_start + 7.days
    @week_days = (week_start..week_end).to_a # to_aは、配列に変換
    @prev_week = week_start - 7.days # 今週の月曜日から7日前 → 前週の月曜日
    @next_week = week_start + 7.days # 今週の月曜日から7日後 → 次週の月曜日
    @selected_date =
      if params[:date].present?
        Date.parse(params[:date]) #  Date.parse：Date オブジェクトに変換するメソッド
      elsif @week_days.include?(Date.today)
        Date.today
      else
        week_start #　月曜日
      end
  end
end
