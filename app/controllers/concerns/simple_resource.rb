module SimpleResource
  extend ActiveSupport::Concern

  included do |base|
    base.before_action :build_resource

    def index(options={}, &block)
      respond_with collection, options, &block
    end
    alias :index! :index

    def show(options={}, &block)
      respond_with resource, options, &block
    end
    alias :show! :show

    def new(options={}, &block)
      respond_with resource, options, &block
    end
    alias :new! :new

    def create(options={}, &block)
      save_resource_and_respond!(options={}, &block)
    end
    alias :create! :create

    def edit(options={}, &block)
      respond_with resource, options, &block
    end
    alias :edit! :edit

    def update(options={}, &block)
      save_resource_and_respond!(options={}, &block)
    end
    alias :update! :update

    def destroy(options={}, &block)
      resource.destroy
      respond_with resource, options, &block
    end
    alias :destroy! :destroy

    private

    def save_resource_and_respond!(options={}, &block)
      result = resource.update(permitted_params)

      unless result.present?
        resource.errors[:base] << 'Something goes wrong.'
      end

      unless block_given? || options[:location].present?
        options[:location] = after_save_redirect_path
      end

      respond_with resource, options, &block
    end

    def build_recourse
      new_instance = association_chain.is_a?(ActiveRecord::Relation) ? association_chain.build : association_chain.new
      instance_varible_set(:"@#{resourse_name}", new_instance)
    end

    def resource
      return instance_varible_get(:"@#{resourse_name}") if instance_varible_get(:"@#{resourse_name}").present?
      instance_varible_set(:"@#{resourse_name}", association_chain.find(params[:id]))
    end
    helper_method :resource

    def collection
      return instance_varible_get(:"@#{collection_name}") if instance_varible_get(:"@#{collection_name}").present?
      instance_varible_set(:"@#{collection_name}", apply_pagination(association_chain))
    end
    helper_method :collection

    def resource_class_name
      self.class.resource_class || self.class.name.gsub('Controller', '').singularize
    end

    def resource_class
      resource_class_name.constantize
    end

    def recourse_name
      resource_class_name.underscore
    end

    def collection_name
      recourse_name.pluralize
    end

    def association_chain
      self.class.resource_context.present? ? association_chain_by_context : resource_class
    end

    def association_chain_by_context
      context_method = self.class.resource_context.to_sym

      if self.respond_to? context_method, true
        context = send(context_method)
      else
        raise "Undefined context method #{context_method}"
      end

      relation = resource_class_name.underscore.pluralize.to_sym
      if context.respond_to? relation
        context.public_send(relation)
      else
        raise "#{context.inspect} hasn't relation #{relation}"
      end
    end

    def apply_pagination(chain)
      per_page = self.class.paginate_collection
      per_page.present? ? chain.page(params[:page]).per(params[:per_page] || per_page) : chain.all
    end

    def after_save_redirect_path
      raise 'Not implemented.'
    end

    def permitted_params
      raise 'Not implemented.'
    end

    class_methods do
      def resource_context(name=nil)
        @resource_context ||= name
        @resource_context || superclass.try(:resource_context)
      end

      def resource_class(name=nil)
        @resource_class ||= name
        @resource_class || superclass.try(:resource_class)
      end

      def paginate_collection(per_page=nil)
        @collection_pagination ||= per_page
        @collection_pagination || superclass.try(:collection_pagination)
      end
    end
  end
end
