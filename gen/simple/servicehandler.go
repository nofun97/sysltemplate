// Code generated by sysl DO NOT EDIT.
package simple

import (
	"net/http"

	"github.com/joshcarp/sysltemplate/gen/mydependency"
	"github.service.anz/sysl/server-lib/common"
	"github.service.anz/sysl/server-lib/restlib"
	"github.service.anz/sysl/server-lib/validator"
)

// Handler interface for simple
type Handler interface {
	GetFoobarListHandler(w http.ResponseWriter, r *http.Request)
}

// ServiceHandler for simple API
type ServiceHandler struct {
	genCallback                     GenCallback
	serviceInterface                *ServiceInterface
	mydependencymydependencyService mydependency.Service
}

// NewServiceHandler for simple
func NewServiceHandler(genCallback GenCallback, serviceInterface *ServiceInterface, mydependencymydependencyService mydependency.Service) *ServiceHandler {
	return &ServiceHandler{genCallback, serviceInterface, mydependencymydependencyService}
}

// GetFoobarListHandler ...
func (s *ServiceHandler) GetFoobarListHandler(w http.ResponseWriter, r *http.Request) {
	if s.serviceInterface.GetFoobarList == nil {
		s.genCallback.HandleError(r.Context(), w, common.InternalError, "not implemented", nil)
		return
	}

	ctx := common.RequestHeaderToContext(r.Context(), r.Header)
	ctx = common.RespHeaderAndStatusToContext(ctx, make(http.Header), http.StatusOK)
	var req GetFoobarListRequest

	ctx, cancel := s.genCallback.DownstreamTimeoutContext(ctx)
	defer cancel()
	client := GetFoobarListClient{
		GetTodos: s.mydependencymydependencyService.GetTodos,
	}

	valErr := validator.Validate(&req)
	if valErr != nil {
		s.genCallback.HandleError(ctx, w, common.BadRequestError, "Invalid request", valErr)
		return
	}

	str, err := s.serviceInterface.GetFoobarList(ctx, &req, client)
	if err != nil {
		s.genCallback.HandleError(ctx, w, common.DownstreamUnexpectedResponseError, "Downstream failure", err)
		return
	}

	headermap, httpstatus := common.RespHeaderAndStatusFromContext(ctx)
	restlib.SetHeaders(w, headermap)
	restlib.SendHTTPResponse(w, httpstatus, str, err)
}
