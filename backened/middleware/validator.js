const Joi = require('joi');

// 1️⃣ Define your schemas with custom messages:
const registrationSchema = Joi.object({
  name: Joi.string()
    .trim()
    .min(2)
    .required()
    .messages({
      'string.empty':   'Name is required',
      'string.min':     'Name must be at least 2 characters long',
    }),

  email: Joi.string()
    .trim()
    .email({ tlds: { allow: false } })
    .required()
    .messages({
      'string.empty':   'Email is required',
      'string.email':   'Please enter a valid email',
    }),

  password: Joi.string()
    .min(6)
    .pattern(/\d/)
    .required()
    .messages({
      'string.empty':   'Password is required',
      'string.min':     'Password must be at least 6 characters long',
      'string.pattern.base': 'Password must contain at least one number',
    }),
});

const loginSchema = Joi.object({
  email: Joi.string()
    .trim()
    .email({ tlds: { allow: false } })
    .required()
    .messages({
      'string.empty': 'Email is required',
      'string.email': 'Please enter a valid email',
    }),

  password: Joi.string()
    .required()
    .messages({
      'string.empty': 'Password is required',
    }),
});

// 2️⃣ Create middleware to validate against those schemas:
function validateBody(schema) {
  return (req, res, next) => {
    const { error } = schema.validate(req.body, {
      abortEarly: false,    // gather all errors
      allowUnknown: false,  // disallow fields not in schema
      stripUnknown: true,   // remove unknown fields
    });

    if (error) {
      // Format Joi errors into an array like express-validator
      const errors = error.details.map((d) => ({
        field:   d.path.join('.'),
        message: d.message
      }));
      return res.status(400).json({ message : errors });
    }
    next();
  };
}

// 3️⃣ Export two specific middlewares
const validateRegistration = validateBody(registrationSchema);
const validateLogin        = validateBody(loginSchema);

module.exports = { validateRegistration, validateLogin };
