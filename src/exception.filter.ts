import { ArgumentsHost, Catch, ExceptionFilter } from '@nestjs/common';
import { Response } from 'express';
import { GraphQLException } from './graphql.exception';

@Catch()
export class GraphQLExceptionFilter implements ExceptionFilter<GraphQLException> {
  catch(exception: GraphQLException, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse<Response>();
    
    response.status(422).json({
      statusCode: 422,
      message: exception.message,
    });
  }
}
