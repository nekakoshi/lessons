class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    ### 基準点の場所
    article =  Article.first
  
    ### 検索範囲の数値、単位はKM
    ### 単位はKM
    ### デフォルトは10
    distance_km = params[:distance] || 10
  
    ### 緯度経度の検索
    ### 基準点からの検索距離内を条件として検索
    ### 緯度経度を保持しているデータを対象とする
    @articles = Article.within(distance_km, origin: article.location)
      .by_distance(origin: article.location)
      .where.not(id: article.location)
  
    ### 表示マーカーのフォーマットを整形する
    @location_markers = Gmaps4rails.build_markers @articles do |article, marker|
      ### マーカーに緯度経度のデータを追加する。
      marker.lat article.latitude
      marker.lng article.longitude

      ### クリック時の表示情報を追加する。(HTMLタグ利用可能)
      marker.infowindow "<strong>#{article.title}</strong>"

      ### 表示時のアイコンを指定する。
      marker.picture({
        #url: ActionController::Base.helpers.asset_path('aed.png'),
        width: 32,
        height: 32
      })
      marker.json({id: article.id, icon: ''})
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :address, :latitude, :longitude)
    end
end
