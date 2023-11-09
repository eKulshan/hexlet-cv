# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    form = Web::Resumes::SearchForm.new(params[:q])
    @bot = AiBotHelper.ai_bot_user
    @q = Resume.web.with_locale.ransack(form.to_h)
    @resumes = @q.result(distinct: true).includes(:user, :skills).page(params[:page]).order(id: :desc)
    @page = params[:page]
    @tags = Resume.directions_tags

    set_meta_tags title: t('titles.web.base'),
                  canonical: root_url,
                  og: {
                    description: t('.description'),
                    type: 'website',
                    title: t('titles.web.base'),
                    url: root_url
                  }
  end
end
