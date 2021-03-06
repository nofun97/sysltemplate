// Code generated by sysl DO NOT EDIT.
package simple

import (
	"time"

	"github.com/rickb777/date"
	"github.service.anz/sysl/server-lib/validator"
)

// Reference imports to suppress unused errors
var _ = time.Parse

// Reference imports to suppress unused errors
var _ = date.Parse

// Stuff ...
type Stuff struct {
	Content string `json:"Content"`
}

// GetFoobarListRequest ...
type GetFoobarListRequest struct {
}

// *Stuff validator
func (s *Stuff) Validate() error {
	return validator.Validate(s)
}

// Str ...
type Str string
